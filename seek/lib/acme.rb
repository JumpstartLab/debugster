require 'yaml/store'
require 'active_support/core_ext/string'

Employee = Struct.new(:name, :phone)

module Acme

  def self.directory
    @directory ||= Directory.new
  end

  def self.find(name)
    directory.find(name)
  end

  class Directory
    def find(name)
      employees.select do |employee|
        employee.send(:name).titlecase =~ /#{name}/i
      end
    end

    def employees
      unless @employees
        db.transaction do
          @employees = db['employees']
        end
      end
      @employees
    end

    def db
      @db ||= YAML::Store.new "#{data_dir}/acme.directory.yml"
    end

    def data_dir
      @data_dir ||= File.join(File.dirname(File.dirname(__FILE__)), 'data')
    end
  end
end
