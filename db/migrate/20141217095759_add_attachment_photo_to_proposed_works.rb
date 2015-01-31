class AddAttachmentPhotoToProposedWorks < ActiveRecord::Migration
  def self.up
    change_table :proposed_works do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :proposed_works, :photo
  end
end
