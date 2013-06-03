class User2 < ActiveRecord::Base
  self.table_name = :users
end

class Agent < ActiveRecord::Base

end

class UsersHaveTheirOwnTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name, limit: 50
      t.string :summary, limit: 500
      t.string :slug, limit: 50
      t.boolean :admin
      t.string :email
      t.string :avatar_image
      t.string :email
      t.string :password_digest
      t.string :reset_password_token
      t.integer :login_count
      t.datetime :last_login_at

      t.timestamps
    end

    Agent.where(type: "User").each do |a|
      u = User2.new
      u.id = a.id
      u.name = a.name
      u.email = a.email
      u.password_digest = a.password_digest
      u.admin = a.admin?
      u.save!(validate: false)
      u.update_column :slug, a.slug
      u.update_column :login_count, a.login_count
      u.update_column :created_at, a.created_at
      u.update_column :updated_at, a.updated_at

      execute "UPDATE sections SET document_type = 'User' WHERE document_type = 'Agent' AND document_id = #{a.id}"
      execute "UPDATE users SET avatar_image = (SELECT avatar_image FROM agents WHERE id = #{a.id}) WHERE id = #{u.id}"
      execute "DELETE from agents WHERE id = #{u.id}"
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
