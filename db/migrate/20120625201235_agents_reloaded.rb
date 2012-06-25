class AgentsReloaded < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false
    drop_table :agents

    create_table :locations do |t|
      t.string :resource_type, limit: 16
      t.integer :resource_id
      t.integer :user_id
      t.string :title, limit: 200
      t.float :latitude
      t.float :longitude
      t.timestamps
    end

    create_table :agents do |t|
      t.string :type, limit: 8 
      t.string :name, limit: 50
      t.string :title, limit: 100
      t.string :slug, limit: 50
      t.boolean :admin
      t.string :avatar_image
      t.string :lang, limit: 8
      t.string :email
      t.text :settings
      t.integer :kudos_count, default: 0
      t.integer :view_count, default: 0

      # User specific
      t.string :password_digest
      t.string :reset_password_token
      t.integer :login_count
      t.datetime :last_login_at

      # Group specific
      t.integer :user_id
      t.string :subdomain, limit: 50
      t.integer :memberships_count
      t.string :banner_image

      t.timestamps
    end
    add_index :agents, :type
    add_index :agents, :slug
    add_index :agents, :email

    migrate_data
  end

  def down
    drop_table :locations
  end

  def migrate_data
    migrate_users
    migrate_groups
  end

  def migrate_users
    say 'Migrating users...'
    Ouser.order('id ASC').each do |old|
      say "User #{old.title} #{old.id}"
      ActiveRecord::Base.record_timestamps = false
      user = User.new
      user.name = old.title.slice(0, 40)
      user.slug = user.name.parameterize
      user.title = old.title
      user.city = old.city
      user.country = old.country
      user.lang = old.lang || 'es'
      user.admin = old.admin?
      user.email = old.email
      user.password_digest = old.password_digest
      user.reset_password_token = old.reset_password_token
      user.reset_password_sent_at = old.reset_password_sent_at
      user.login_count = old.login_count
      user.last_login_at = old.last_login_at
      user.avatar_image = old.avatar_image
      add_timestamps(user, old)
      safe_save(user)

      ActiveRecord::Base.record_timestamps = true
      last = user.sections.create!(lang: 'es', body_type: 'markdown',
                            body: old.description)
      clean_sections(user, last)
      add_location(user.id, user, old)

      say "Now #{user.name} #{user.id}"
      say "PROBLEM" if user.id != old.id
    end
  end

  def migrate_groups
    say 'Migrating groups...'
    Ogroup.reorder('id ASC').each do |old|
      say "Group #{old.title} #{old.id}"
      ActiveRecord::Base.record_timestamps = false
      group = Group.new
      group.name = old.title.slice(0, 40)
      group.slug = group.name.parameterize
      group.title = old.title

      group.banner_image = old.banner_image
      group.avatar_image = old.avatar_image
      group.city = old.city
      group.country = old.country
      group.lang = old.lang || 'es'
      group.website = old.website
      group.twitter = old.twitter
      group.facebook = old.facebook
      group.subdomain = old.subdomain
      group.memberships_count = old.memberships_count
      group.closed = old.closed?
      group.admin = old.root?
      add_timestamps(group, old)
      safe_save(group)

      ActiveRecord::Base.record_timestamps = true
      last = group.sections.create!(lang: 'es', body_type: 'markdown',
                             body: old.description_es)
      clean_sections(group, last)
      add_location(group.user_id, group, old)

      [Announcement, Content, Membership, Message, PostAttachment, Experiencie, Proposal, Version].each do |model|
        model.where(group_id: old.id).update_all(group_id: group.id)
      end
      say "Now #{group.name} #{group.id}"
    end
  end

  def clean_sections(agent, last)
    last_id = last.body.blank? ? -1 : last.id
    agent.sections.each do |section|
      section.destroy unless section.id == last_id
    end
  end

  def safe_save(model)
    model.save(validate: false)
  end

  def add_timestamps(model, old)
    model.created_at = old.created_at
    model.updated_at = old.updated_at
  end

  def add_location(user_id, model, old)
    model.locations.create!(latitude: old.latitude, 
                            longitude: old.longitude,
                            user_id: user_id)
  end

end
