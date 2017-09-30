ActiveAdmin.register MagicPlayer do
  permit_params :first_name, :last_name, :email, :dci_number, :store_credit

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :dci_number, label: "DCI Number"
    column :store_credit
    actions
  end

  filter :first_name, filters: [:equals, :contains]
  filter :last_name, filters: [:equals, :contains]
  filter :email, filters: [:equals, :contains]
  filter :dci_number, filters: [:equals]

  show do
    columns do
      column do
        attributes_table do
          row :first_name
          row :last_name
          row :email
          row :dci_number, label: "DCI Number"
          row :store_credit
        end
      end
      column do
        panel "Store Credit Ledger" do
          table_for magic_player.credit_ledger_items.order(created_at: :desc) do
            column :amount do |item|
              item.display_amount
            end
            column :created_at
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Player Information" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :dci_number, label: "DCI Number"
      f.input :store_credit
    end
    actions
  end

  controller do
    def update
      outcome = MagicPlayers::Update.run(
        magic_player: MagicPlayer.find(params[:id]),
        params: params[:magic_player].to_unsafe_h
      )
      if outcome.valid?
        redirect_to admin_magic_player_path(outcome.result)
      else
        @magic_player = outcome.result
        render :edit
      end
    end
  end
end
