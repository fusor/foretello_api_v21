class DiscoveredHostSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name,
             :ip, :last_report, :mac,
             :subnet_id, :subnet_name,
             :memory, :disk_count, :disks_size, :cpus,
             :organization_id, :organization_name, :location_id, :location_name,
             :created_at, :updated_at
end
