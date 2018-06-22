variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}

variable "tenant_id" {
    description = "GUID for the Azure AD tenancy or directory"
}

variable "object_id" {
    description = "Object ID for the terraformKeyVaultReader service principal"
}

variable "webapplocs" {
    description = "List of locations for web apps"
    type        = "list"
    default     = []
}