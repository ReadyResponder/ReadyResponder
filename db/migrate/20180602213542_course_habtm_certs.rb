class CourseHabtmCerts < ActiveRecord::Migration
  def up
    create_table "certs_courses" do | t |
      t.integer :cert_id
      t.integer :course_id
    end
    Cert.all.each do | c |
      # efficient? no, but the scale is so small it doesn't really matter
      Cert.connection.execute("insert into certs_courses (cert_id, course_id)
                               values (#{c.id}, #{c.course_id})")
    end
  end

  def down
    add_column :certs, :course_id, :integer
    Cert.connection.schema_cache.clear!
    Cert.reset_column_information
    Cert.connection.select_rows("SELECT cert_id, course_id FROM certs_courses").each do | row |
      # again, not the most efficient but it'll work if you have habtm or
      # belongs_to in your class when you run this.
      Cert.connection.execute("update certs set course_id = #{row[1]} where id = #{row[0]}")
    end
    drop_table "certs_courses" if table_exists? "certs_courses"
  end
end
