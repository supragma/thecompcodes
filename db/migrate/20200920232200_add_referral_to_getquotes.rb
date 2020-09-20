class AddReferralToGetquotes < ActiveRecord::Migration[6.0]
  def change
    add_column :getquotes, :referral, :string
  end
end
