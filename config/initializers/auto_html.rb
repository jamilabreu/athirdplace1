AutoHtml.add_filter(:linked_image).with(:alt => '') do |text, options|
  text.gsub(/http:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    %|<a href="#{match}" target="_blank"><img src="#{match}" alt="" /></a>|
  end
end
AutoHtml.add_filter(:twitter) do |text, options|
  text.gsub(/(?:^|\s)\@(\w+)\b/) do |match|
    %|<a href="http://twitter.com/#{match[1..-1]}" target="_blank">#{match}</a>|
  end
end

