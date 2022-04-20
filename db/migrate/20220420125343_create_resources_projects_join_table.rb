class CreateResourcesProjectsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :resources, :projects
  end
end
