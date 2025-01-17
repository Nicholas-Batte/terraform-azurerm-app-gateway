# COMMON

variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

# PUBLIC IP

variable "ip_sku" {
  description = "SKU for the public IP. Warning, can only be `Standard` for the moment."
  type        = string
  default     = "Standard"
}

variable "ip_allocation_method" {
  description = "Allocation method for the public IP. Warning, can only be `Static` for the moment."
  type        = string
  default     = "Static"
}

# Application gateway inputs

variable "sku_capacity" {
  description = "The Capacity of the SKU to use for this Application Gateway - which must be between 1 and 10, optional if autoscale_configuration is set"
  type        = number
  default     = 2
}

variable "sku" {
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_v2 and WAF_v2."
  type        = string
  default     = "WAF_v2"
}

variable "zones" {
  description = "A collection of availability zones to spread the Application Gateway over. This option is only supported for v2 SKUs"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "frontend_port_settings" {
  description = "Frontend port settings. Each port setting contains the name and the port for the frontend port."
  type        = list(map(string))
}

variable "ssl_policy" {
  description = "Application Gateway SSL configuration. The list of available policies can be found here: https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-ssl-policy-overview#predefined-ssl-policy"
  type        = any
  default     = null
}

variable "ssl_profile" {
  description = "Application Gateway SSL profile. Default profile is used when this variable is set to null."
  type        = any
  default     = null
}

variable "firewall_policy_id" {
  description = "ID of a Web Application Firewall Policy"
  type        = string
  default     = null
}

variable "trusted_root_certificate_configs" {
  description = "List of trusted root certificates. The needed values for each trusted root certificates are 'name' and 'data' or 'filename'. This parameter is required if you are not using a trusted certificate authority (eg. selfsigned certificate)"
  type        = list(map(string))
  default     = []
}

variable "appgw_backend_pools" {
  description = "List of maps including backend pool configurations"
  type        = any
}

variable "appgw_http_listeners" {
  description = "List of maps including http listeners configurations and map of maps including listener custom error configurations"
  type        = any
}

variable "custom_error_configuration" {
  description = "List of maps including global level custom error configurations"
  type        = list(map(string))
  default     = []
}

variable "ssl_certificates_configs" {
  description = <<EOD
List of maps including ssl certificates configurations.
The path to a base-64 encoded certificate is expected in the 'data' parameter:
```
data = filebase64("./file_path")
```
EOD
  type        = list(map(string))
  default     = []
}

variable "appgw_routings" {
  description = "List of maps including request routing rules configurations. If you wish to use rule `priority`, you will have to specify rule-priority field values for all the existing request routing rules. Once the rule priority field is in use, any new routing rule that is created would also need to have a rule priority field value as part of its config."
  type        = list(map(string))
}

variable "appgw_probes" {
  description = "List of maps including request probes configurations"
  type        = any
  default     = []
}

variable "appgw_backend_http_settings" {
  description = "List of maps including backend http settings configurations"
  type        = any
}

variable "appgw_url_path_map" {
  description = "List of maps including url path map configurations"
  type        = any
  default     = []
}

variable "appgw_redirect_configuration" {
  description = "List of maps including redirect configurations"
  type        = list(map(string))
  default     = []
}

### REWRITE RULE SET

variable "appgw_rewrite_rule_set" {
  description = "List of rewrite rule set including rewrite rules"
  type        = any
  default     = []
}

### WAF

variable "enable_waf" {
  description = "Boolean to enable WAF."
  type        = bool
  default     = true
}

variable "file_upload_limit_mb" {
  description = " The File Upload Limit in MB. Accepted values are in the range 1MB to 500MB. Defaults to 100MB."
  type        = number
  default     = 100
}

variable "waf_mode" {
  description = "The Web Application Firewall Mode. Possible values are Detection and Prevention."
  type        = string
  default     = "Prevention"
}

variable "max_request_body_size_kb" {
  description = "The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB."
  type        = number
  default     = 128
}

variable "request_body_check" {
  description = "Is Request Body Inspection enabled?"
  type        = bool
  default     = true
}

variable "rule_set_type" {
  description = "The Type of the Rule Set used for this Web Application Firewall."
  type        = string
  default     = "OWASP"
}

variable "rule_set_version" {
  description = "The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, and 3.1."
  type        = number
  default     = 3.1
}

variable "disabled_rule_group_settings" {
  description = "The rule group where specific rules should be disabled. Accepted values can be found here: https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#rule_group_name"
  type = list(object({
    rule_group_name = string
    rules           = list(string)
  }))
  default = []
}

variable "disable_waf_rules_for_dev_portal" {
  description = "Whether to disable some WAF rules if the APIM developer portal is hosted behind this Application Gateway. See locals.tf for the documentation link"
  type        = bool
  default     = false
}

variable "waf_exclusion_settings" {
  description = "WAF exclusion rules to exclude header, cookie or GET argument. More informations on: https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#match_variable"
  type        = list(map(string))
  default     = []
}

### NETWORKING

variable "virtual_network_name" {
  description = "Virtual network name to attach the subnet."
  type        = string
}

variable "subnet_resource_group_name" {
  description = "Resource group name of the subnet."
  type        = string
  default     = ""
}

variable "create_subnet" {
  description = "Boolean to create subnet with this module."
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "Custom subnet ID for attaching the Application Gateway. Used only when the variable `create_subnet = false`."
  type        = string
  default     = ""
}

variable "route_table_name" {
  description = "The Route Table name to associate with the subnet"
  type        = string
  default     = null
}

variable "route_table_rg" {
  description = "The Route Table RG to associate with the subnet. Default is the same RG than the subnet."
  type        = string
  default     = null
}

variable "subnet_cidr" {
  description = "Subnet CIDR to create."
  type        = string
  default     = ""
}

variable "create_nsg" {
  description = "Boolean to create the network security group."
  type        = bool
  default     = false
}

variable "create_nsg_https_rule" {
  description = "Boolean to create the network security group rule opening https to everyone."
  type        = bool
  default     = true
}

variable "create_nsg_healthprobe_rule" {
  description = "Boolean to create the network security group rule for the health probes."
  type        = bool
  default     = true
}

variable "nsr_https_source_address_prefix" {
  description = "Source address prefix to allow to access on port 443 defined in dedicated network security rule."
  type        = string
  default     = "*"
}

### IDENTITY

variable "user_assigned_identity_id" {
  description = "User assigned identity id assigned to this resource"
  type        = string
  default     = null
}

### APPGW PRIVATE

variable "appgw_private" {
  description = "Boolean variable to create a private Application Gateway. When `true`, the default http listener will listen on private IP instead of the public IP."
  type        = bool
  default     = false
}

variable "appgw_private_ip" {
  description = "Private IP for Application Gateway. Used when variable `appgw_private` is set to `true`."
  type        = string
  default     = null
}

variable "enable_http2" {
  description = "Whether to enable http2 or not"
  type        = bool
  default     = true
}

### Autoscaling

variable "autoscaling_parameters" {
  type        = map(string)
  description = "Map containing autoscaling parameters. Must contain at least min_capacity"
  default     = null
}
