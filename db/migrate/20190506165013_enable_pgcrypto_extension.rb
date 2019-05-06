class EnablePgcryptoExtension < ActiveRecord::Migration[5.2]
  def change
    enable_extension "plpgsql"
    enable_extension 'pgcrypto'    
  end
end
