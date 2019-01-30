nokogiri = Nokogiri.HTML(content)

#load products
products = nokogiri.css('#mainResults li', '#resultsCol li')
products.each do |product|
  a_element = product.at_css('a.s-access-detail-page')
  if a_element
    url = a_element['href'].gsub(/&qid=[0-9]*/,'')
    if url =~ /\Ahttps?:\/\//i
      pages << {
          url: url,
          page_type: 'products',
          vars: {
            category: page['vars']['category'],
            url: url
          }
        }
    end
  end
end

#load paginated links
pagination_links = nokogiri.css('#pagn a')
pagination_links.each do |link|
  url = URI.join('https://www.amazon.com', link['href']).to_s.gsub(/&qid=[0-9]*/,'')
  pages << {
      url: url,
      page_type: 'listings',
      vars: {
        category: page['vars']['category']
      }
    }
end
