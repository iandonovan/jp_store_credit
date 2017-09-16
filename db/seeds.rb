require 'csv'

CSV.foreach(Rails.root.join('lib', 'seeds', 'players.csv'), headers: true) do |row|
  name_array = row[0].split(",").map(&:squish)
  if name_array.size == 1
    first_name = name_array[0]
    last_name = nil
  else
    first_name = name_array[1]
    last_name = name_array[0]
  end
  credit_string = row[1]
  if credit_string.present?
    credit_number = credit_string.sub("$", "").to_f
  else
    credit_number = 0.0
  end
  player = MagicPlayer.create!(
    first_name: first_name,
    last_name: last_name,
    store_credit: credit_number
  )
  player.credit_ledger_items.create(amount: credit_number)
end
