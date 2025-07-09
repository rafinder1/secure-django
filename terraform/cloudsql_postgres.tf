resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = var.tier

    ip_configuration {
      ipv4_enabled    = true

    #   private_network = var.private_network # np. "projects/YOUR_PROJECT_ID/global/networks/default"
    }

    backup_configuration {
      enabled = true
    }

    activation_policy = "ALWAYS"
  }

  deletion_protection = false
}

resource "google_sql_user" "postgres_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = var.db_password
}

resource "google_sql_database" "postgres_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
}
