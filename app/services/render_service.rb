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
      when "quote"
        build_quote(block["data"]["text"], block["data"]["caption"], block["data"]["alignment"])
      when "table"
        build_table(block["data"]["withHeadings"], block["data"]["content"])
      else
        ""
      end
    end
    content_html.join.html_safe
  end

  private

  def build_alert(type, message, alignment)
    alert_types = {
      "danger" => { icon: '<i class="fa-solid fa-triangle-exclamation" style="color: #a80000;"></i>', color: "danger_alert" },
      "info" => { icon: '<i class="fa-solid fa-circle-info" style="color: #00a2b1;"></i>', color: "info_alert" },
      "warning" => { icon: '<i class="fa-solid fa-circle-exclamation" style="color: #b17601;"></i>', color: "warning_alert" },
      "primary" => { icon: '<i class="fa-solid fa-circle-info" style="color: #0071ad;"></i>', color: "primary_alert" },
      "secondary" => { icon: '<i class="fa-solid fa-circle-info" style="color: #005994;"></i>', color: "secondary_alert" },
      "success" => { icon: '<i class="fa-solid fa-circle-check" style="color: #00a32c;"></i>', color: "success_alert" },
      "light" => { icon: '<i class="fa-solid fa-circle-info" style="color: #778da3;"></i>', color: "light_alert" },
      "dark" => { icon: '<i class="fa-solid fa-circle-info" style="color: #fff;"></i>', color: "dark_alert" },
    }

    icon = alert_types[type][:icon]
    color = alert_types[type][:color]

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

  def build_quote(text, caption, alignment)
    caption = "<caption>#{caption}</caption>"
    "<blockquote>
      <p>#{text}</p>
      #{caption if caption}
    </blockquote>"
  end

  def build_table(has_headings, content)
    head, body_rows = "", []
    content.each_with_index do |row, index|
      if index == 0 && has_headings
        head = build_table_head(row)
      else
        body_rows << row
      end
    end
    body = build_table_body(body_rows) unless body_rows.empty?
    "<table>#{head}#{body}</table>"
  end

  def build_table_row(tag, row)
    elements = row.map { |cell| "<#{tag}>#{cell}</#{tag}>" }.join
    "<tr>#{elements}</tr>"
  end

  def build_table_head(row)
    "<thead>#{build_table_row("th", row)}</thead>"
  end

  def build_table_body(rows)
    body_rows = rows.map { |row| build_table_row("td", row) }.join
    "<tbody>#{body_rows}</tbody>"
  end
end
