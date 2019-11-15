# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include orengoapps
class orengoapps {
    contain orengoapps::install
    contain orengoapps::config
    
    Class['::orengoapps::install']
    -> Class['::orengoapps::config']
}
