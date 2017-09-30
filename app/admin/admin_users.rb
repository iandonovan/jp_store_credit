ActiveAdmin.register AdminUser, as: "Employee" do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    actions
  end

  filter :first_name, filters: [:equals, :contains]
  filter :last_name, filters: [:equals, :contains]
  filter :email, filters: [:equals, :contains]

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
    end
  end

  form do |f|
    f.inputs "Employee Information" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    actions
  end

  controller do
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end
      super
    end
  end
end
