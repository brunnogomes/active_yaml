require "active_yaml/version"
require 'yaml/store'

module ActiveYaml
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def store
      @store ||= YAML::Store.new("db/#{self.to_s.downcase}.yml")
    end

    def add(record)
      store.transaction do
        id = (store.roots.max || 0) + 1
        record.send(:id=, id)
        store[id] = record
      end
    end

    def update(record)
      store.transaction do
        store[record.id] = record
      end
    end

    def destroy(id)
      store.transaction do
        store.delete(id)
      end
    end

    def first
      store.transaction(true) do
        id = store.roots.min
        store[id]
      end
    end

    def last
      store.transaction(true) do
        size = store.roots.size
        store[size]
      end
    end

    def all
      records = []
      store.transaction(true) do
        store.roots.each do |id|
          records << store[id]
        end
      end
      records
    end

    def count
      store.transaction(true) do
        store.roots.size
      end
    end

    def any?
      store.transaction(true) do
        store.roots.any?
      end
    end

    def empty?
      store.transaction(true) do
        store.roots.empty?
      end
    end

    def find(id)
      store.transaction(true) do
        store[id]
      end
    end

    def find_by(condition)
      key, value = condition.first
      all.each do |record|
        return record if record[key] == value
      end
    end

    def where(conditions)
      found = false
      matches = []
      all.each do |record|
        conditions.each do |condition|
          key, value = condition
          found = (record[key] == value)
        end
        matches << record if found
      end
      matches
    end
  end

  attr_reader :id

  def save
    if new_record?
      self.class.add(self)
    else
      self.class.update(self)
    end
  end

  def destroy
    self.class.destroy(self.id)
  end

  def new_record?
    id.nil?
  end

  private

  def id=(new_id)
    @id = new_id
  end
end
