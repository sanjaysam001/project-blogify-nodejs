resource "google_container_cluster" "blogify_cluster" {
    name = "prod-cluster"
    location ="asia-south1-a"

    node_pool{
        name ="my-nodes"
        node_count = 2

        node_config {
            machine_type = "e2-medium"  #type of machine
            disk_size_gb = 40   #disk space
            disk_type = "pd-standard"   #disk type


        }
    } 
    
    deletion_protection = false


  
}