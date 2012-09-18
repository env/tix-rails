require 'csv'
require './app/lib/tix'

module Tix
  module JamminJavaImporter

    ACCOUNT = Account.find_or_create_by_subdomain('jamminjava').id 
    
    def self.import(filename, model)
      puts "##### Starting Import: #{filename}"

      CSV.foreach(filename, :headers => true ) do |row|
        
        begin
          model.create(row.to_hash)
        rescue ActiveRecord::RecordNotSaved
          # handle save failures here…
        end
      end
    end
    
    
    def self.import_events(filename, model, cat_name)
      puts "##### Starting Import: #{filename}"

      CSV.foreach(filename, :headers => true ) do |row|
        puts "parsing date #{row['starts_at'].to_s}"
        # row['starts_at'] = Date.strptime(row['starts_at'].to_s << "-0500", '%m/%d/%y %H:%M %z')
        row['starts_at'] = DateTime.strptime(row['starts_at'].to_s << " -0500", '%m/%d/%y %H:%M %z')
        puts "got #{row['starts_at']} for #{row['title']}"
        
        row['cat'] = cat_name unless cat_name.nil?
        begin
          model.create(row.to_hash)
        rescue ActiveRecord::RecordNotSaved
          # handle save failures here…
        end
      end
    end
    
    
    # Customers
    def self.import_customers(filename, model)
      puts "##### Starting Import: #{filename}"
      
      # model must respond to #create
      @rejected = []
      
      require 'ostruct'
      
      CSV.foreach(filename, :headers => true) do |row|
        
        # User
        user = OpenStruct.new
        user.first_name = row['first_name'].titleize unless row['first_name'].nil?
        user.last_name = row['last_name'].titleize unless row['last_name'].nil?
        user.email = row['email']
        user.password = row['password']
        
        # puts "#{user.password}\t\t(#{user.email}) \t\t #{user.first_name} #{user.last_name}" 
                
        # Address
        address = OpenStruct.new
        address.address_line_1 = row['address_line_1']
        address.address_line_2 = row['address_line_2']
        address.city = row['city']
        address.state = row['state']
        address.zip = row['zip']
        address.country = row['country']
                
        # Phone
        phone = OpenStruct.new
        phone.number = row['phone']
        
        new_user = model.new( user.marshal_dump)
        new_user.addresses.new( address.marshal_dump)
        new_user.phones.new( phone.marshal_dump)
        
        unless new_user.save
          @rejected << [ user.marshal_dump, address.marshal_dump, phone.marshal_dump ]
        end
        
      end
      @rejected
    end
    
    
    
    def self.import_artist_photos(artist_model)
      require 'open-uri'
      
      # imports photos only if photo does not exist on model
      
      artist_model.each do |artist|
        begin
          unless artist.photo?
            img_url = ''

            open("http://jamminjava.com/home/shaun-data/_get_artist_image/#{artist.id_old}") {|f| f.each_line {|line| img_url += line}}
            img_url = img_url.strip!
            unless img_url.empty?
              file = open(img_url)
              filename = File.basename(img_url)
              artist.photo = file
              artist.photo.instance_write :file_name, filename # otherwise file name will be tempfile
              artist.save
              puts "Saved #{filename} for artist #{artist.name}"
            end
          end
        rescue
          #
        end
      end
    end
    
    
    
    
    
    
    
    
    
  end
  
  
  
  
end