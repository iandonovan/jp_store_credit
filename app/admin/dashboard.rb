ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Comics" do
          para "Comic shoppers could go here"
        end
      end

      column do
        panel "Magic Players" do
          ul do
            MagicPlayer.find_each do |player|
              li link_to player.full_name, admin_magic_player_path(player)
            end
          end
        end
      end
    end
  end
end
