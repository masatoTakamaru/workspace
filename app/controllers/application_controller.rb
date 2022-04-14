class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def initialize
    super
    #学年の定義
    @grades = {
      "未就学": 0, "年少": 1, "年中": 2,
      "年長": 3, "小学１年": 4, "小学２年": 5,
      "小学３年": 6, "小学４年": 7, "小学５年": 8,
      "小学６年": 9, "中学１年": 10, "中学２年": 11,
      "中学３年": 12, "高校１年": 13, "高校２年": 14,
      "高校３年": 15, "既卒": 16}
    @grade_name = @grades.keys
    #生徒数の上限
    @student_limit = 30
    #卒・退会者を含む上限
    @expire_student_limit = 200
    #講座数の上限
    @item_limit = 50
    @item_cats = [
      "単独", "従量", "諸費", "割引"
    ]
    @item_cat_colors = [
      "text-indigo-500",
      "text-teal-500",
      "text-yellow-500",
      "text-pink-500"
    ]
  end

  def after_sign_in_path_for(resource)
    dashboard_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  def student_sort(students)
    if params[:class_name]=="asc"
      students = students.order(class_name: :asc)
    elsif params[:class_name]=="desc"
      students = students.order(class_name: :desc)
    elsif params[:grade]=="asc"
      students = students.order(grade: :asc)
    elsif params[:grade]=="desc"
      students = students.order(grade: :desc)
    end
    students
  end

  protected

    def configure_permitted_parameters
      # deviseのstrongparameter
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

end
