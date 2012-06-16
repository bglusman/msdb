xml.instruct! :xml, :standalone => 'yes'
xml.w :ftr, "xmlns:mo" => "http://schemas.microsoft.com/office/mac/office/2008/main", "xmlns:ve" => "http://schemas.openxmlformats.org/markup-compatibility/2006", "xmlns:mv" => "urn:schemas-microsoft-com:mac:vml", "xmlns:o" => "urn:schemas-microsoft-com:office:office", "xmlns:r" => "http://schemas.openxmlformats.org/officeDocument/2006/relationships", "xmlns:m" => "http://schemas.openxmlformats.org/officeDocument/2006/math", "xmlns:v" => "urn:schemas-microsoft-com:vml", "xmlns:wp" => "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing", "xmlns:w10" => "urn:schemas-microsoft-com:office:word", "xmlns:w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main", "xmlns:wne" => "http://schemas.microsoft.com/office/word/2006/wordml" do
  xml.w :p do
    xml.w :pPr do
      xml.w :pStyle, "w:val" => "Footer"
      xml.w :jc, "w:val" => "right"
    end
    xml.w :r do
      xml.w :t, Date.today.to_formatted_s
    end
  end
end
