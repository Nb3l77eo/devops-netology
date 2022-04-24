locals {
 node1_conf_instance_cores = {
   stage = 2
   prod = 4
 }
 node1_conf_instance_memory = {
   stage = 2
   prod = 4
 }
 node1_conf_instance_platfrom = {
   stage = "standard-v3"
   prod = "standard-v1"
 }
 node1_instance_count = {
   stage = 1
   prod = 2
 }

 feach_env = {
   app = {
     platform = "standard-v1",
     cores = 4,
     memory = 4,
     name = "app"
   },
   db = {
     platform = "standard-v1",
     cores = 4,
     memory = 8,
     name = "db"
   }
 }

}
