class AddTwitterPlaceToConfigs < ActiveRecord::Migration
  def change
    add_column :configs, :twitter_place, :string
  end
end
