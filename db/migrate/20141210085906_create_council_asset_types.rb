class CreateCouncilAssetTypes < ActiveRecord::Migration
  def change
    create_table :council_asset_types do |t|
      t.references :council, index: true
      t.string :asset_type_code

      t.timestamps
    end
  end
end
