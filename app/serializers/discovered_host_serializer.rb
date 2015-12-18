class DiscoveredHostSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  embed :ids, include: true
  attributes :id, :name, :type,
             :ip, :last_report, :mac,
             :subnet_id, :subnet_name,
             :memory, :disk_count, :disks_size, :cpus,
             :organization_id, :organization_name, :location_id, :location_name,
             :created_at, :updated_at,
             :memory_human_size, :disks_human_size,
             :subnet_to_s, :is_virtual

  def cpus
    object.cpu_count
  end

  def memory_human_size
    return "0 MB" if object.memory.blank? || object.memory.to_i == 0
    number_to_human_size(object.memory.to_i * 1024 * 1024)
  end

  def disks_human_size
    return "0 MB" if object.disks_size.blank? || object.disks_size.to_i == 0
    number_to_human_size(object.disks_size.to_i * 1024 * 1024)
  end

  def subnet_to_s
    ""
  end

  def is_virtual
    object.facts['is_virtual']
  end

end
