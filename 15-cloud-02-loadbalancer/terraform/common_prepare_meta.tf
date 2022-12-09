resource "null_resource" "prepare_meta" {
  provisioner "local-exec" {
    command = <<-EOT
	cat meta/common.data.tmp > meta/common.data
	echo "runcmd:" >> meta/common.data 
	echo "  - echo '<html><body><img src=\"https://storage.yandexcloud.net/nb3l77eo-06122022/f51406d4fe8d583540307964caacb7b5.jpg\"/>' > /var/www/html/index.html" >> meta/common.data 
	echo '  - echo "<br> $(hostname)" >> /var/www/html/index.html' >> meta/common.data
	echo "  - echo '</body></html>' >> /var/www/html/index.html" >> meta/common.data 
    EOT
  }
  depends_on = [
    yandex_storage_bucket.test
    ,yandex_storage_object.test-object
  ]
}
