locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  az_map = {
    for az in local.azs :
    substr(az, -1, 1) => az
  }
}
