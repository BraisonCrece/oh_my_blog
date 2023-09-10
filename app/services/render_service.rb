class RenderService
  def call(content)
    parsed_content = JSON.parse(content)
    content_html = parsed_content["blocks"].map do |block|
      case block["type"]
      when "paragraph"
        "<p>#{block["data"]["text"]}</p>"
      when "header"
        build_header(block["data"]["alignment"], block["data"]["level"], block["data"]["text"])
      when "list"
        build_list(block["data"]["items"], block["data"]["style"])
      when "code"
        build_code(block["data"]["code"], block["data"]["language"])
      when "alert"
        build_alert(block["data"]["type"], block["data"]["message"], block["data"]["align"])
      when "image"
        build_image(block["data"]["file"]["url"], block["data"]["caption"], block["data"]["withBorder"], block["data"]["withBackground"], block["data"]["stretched"])
      else
        ""
      end
    end
    content_html.join.html_safe
  end

  private

  def build_alert(type, message, alignment)
    icon, color = case type
      when "danger"
        ['<i class="fa-solid fa-triangle-exclamation" style="color: #a80000;"></i>', "danger_alert"]
      when "info"
        ['<i class="fa-solid fa-circle-info" style="color: #00a2b1;"></i>', "info_alert"]
      when "warning"
        ['<i class="fa-solid fa-circle-exclamation" style="color: #b17601;"></i>', "warning_alert"]
      when "primary"
        ['<i class="fa-solid fa-circle-info" style="color: #0071ad;"></i>', "primary_alert"]
      when "secondary"
        ['<i class="fa-solid fa-circle-info" style="color: #005994;"></i>', "secondary_alert"]
      when "success"
        ['<i class="fa-solid fa-circle-check" style="color: #00a32c;"></i>', "success_alert"]
      when "light"
        ['<i class="fa-solid fa-circle-info" style="color: #778da3;"></i>', "light_alert"]
      when "dark"
        ['<i class="fa-solid fa-circle-info" style="color: #fff;"></i>', "dark_alert"]
      end

    "<div class='render-alert #{color} text-#{alignment}'>
      #{icon}
      #{message}
    </div>"
  end

  def build_list(items, style)
    list = style == "ordered" ? "ol" : "ul"
    list_items = items.map { |item| "<li>#{item}</li>" }.join
    "<#{list}>#{list_items}</#{list}>"
  end

  def build_header(alignment, level, text)
    "<h#{level} style='text-align: #{alignment}'>#{text}</h#{level}>"
  end

  def build_code(code, language)
    escaped_code = CGI.escapeHTML(code)
    "<pre class='language-#{language}'><code>#{escaped_code}</code></pre>"
  end

  def build_image(url, caption, with_border, with_background, stretched)
    container_classes = ["image-container"]
    container_classes << "image-border" if with_border
    container_classes << "image-background" if with_background

    image_classes = ["image"]
    image_classes << "image-stretched" if stretched
    image_classes << "image-with-background" if with_background

    container_class = container_classes.join(" ")
    image_class = image_classes.join(" ")

    image_html = <<-HTML
              <figure class="#{container_class}">
                  <img src='#{url}' alt='#{caption}' class='#{image_class}' />
                  <figcaption class="centered-content">#{caption}</figcaption>
              </figure>
          HTML
  end
end
