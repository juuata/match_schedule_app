module ApplicationHelper
  def nav_link_to(name_or_path, path = nil, &block)
    base_class = "px-4 h-20 flex items-center font-medium transition duration-200"
    active_class = "text-green-600 border-b-2 border-green-600 bg-green-50"
    inactive_class = "text-gray-700 hover:bg-gray-200"

    if block_given?
      # ブロックがある場合、第一引数がパス
      actual_path = name_or_path
      is_active = current_page?(actual_path)
      css_class = "#{base_class} #{is_active ? active_class : inactive_class}"
      link_to actual_path, class: css_class, &block
    else
      # ブロックがない場合、第一引数が名前、第二引数がパス
      is_active = current_page?(path)
      css_class = "#{base_class} #{is_active ? active_class : inactive_class}"
      link_to name_or_path, path, class: css_class
    end
  end
end
