class DomainSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name, :fullname, :dns_id, :total_hosts, :hostgroups_count, :created_at, :updated_at
  # has_many :locations
  # has_many :organizations
  # has_many :parameters
#  has_many :
  #has_many :subnets
  #has_many :hostgroups
end
