
data "template_file" "mgmt_meta" {
  template = file("metadata/_mgmt_meta.tpl")

  vars = {
    YC_cloud_id = var.YC_cloud_id
    YC_folder_id = var.YC_folder_id
    k8s-id = yandex_kubernetes_cluster.k8s-regional.id
    username_def = var.username_def
    ssh_key_def = file("~/.ssh/id_rsa.pub")
  }
  depends_on = [
    yandex_kubernetes_cluster.k8s-regional
  ]
}

data "template_file" "prepare-deploy-tpl" {
  template = file("src/phpmyadmin_dep.yaml.tpl")

  vars = {
    mysql-clu-id = yandex_mdb_mysql_cluster.first_mysql_clu.id
  }
  depends_on = [
    yandex_mdb_mysql_cluster.first_mysql_clu
  ]
}

resource "local_file" "saved-manifesto" {
  content = data.template_file.prepare-deploy-tpl.rendered
  filename = "src/phpmyadmin_dep.yaml"
  depends_on = [
    data.template_file.prepare-deploy-tpl
  ]
}


resource "null_resource" remoteExecProvisionerWFolder {

  provisioner "file" {
    source      = "src/phpmyadmin_dep.yaml"
    destination = "/tmp/phpmyadmin_dep.yaml"
  }

  connection {
    host     = yandex_compute_instance.mgmt-node.network_interface.0.nat_ip_address
    type     = "ssh"
    user     = var.username_def
    private_key = file("~/.ssh/id_rsa")
  }
  depends_on = [
    yandex_compute_instance.mgmt-node
    ,yandex_kubernetes_node_group.k8s_ng-a
    ,local_file.saved-manifesto
  ]
}



resource "null_resource" "wait_mgmt_prepare" {
  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [
    null_resource.remoteExecProvisionerWFolder
  ]
}



resource "null_resource" "apply_k8s_deploy" {
  provisioner "local-exec" {
    command = "ssh ${var.username_def}@${yandex_compute_instance.mgmt-node.network_interface.0.nat_ip_address} kubectl apply -f /tmp/phpmyadmin_dep.yaml"
  }
  depends_on = [
    null_resource.wait_mgmt_prepare

  ]
}




resource "null_resource" "wait_k8s_deploying" {
  provisioner "local-exec" {
    command = "sleep 30"
  }
  depends_on = [
    null_resource.apply_k8s_deploy
  ]
}


resource "null_resource" "get_ext_ip_lb" {
  provisioner "local-exec" {
    command = "ssh ${var.username_def}@${yandex_compute_instance.mgmt-node.network_interface.0.nat_ip_address} kubectl get service phpmyadmin-service -o=json | jq '.status.loadBalancer.ingress | .[].ip' > ${path.module}/src/ip_lb.tpl"
  }
  depends_on = [
    null_resource.wait_k8s_deploying
  ]
}

data "template_file" "ext_ip_lb" {
  template = file("src/ip_lb.tpl")
  depends_on = [
    null_resource.get_ext_ip_lb
  ]
}