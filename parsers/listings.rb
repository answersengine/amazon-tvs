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
  page_num = link.text.strip
  if page_num =~ /[0-9]/
    url = "https://www.amazon.com/s/ref=sr_pg_3?rh=n%3A172282%2Cn%3A%21493964%2Cn%3A1266092011%2Cn%3A172659%2Cn%3A6459737011&page=#{page_num}&ie=UTF8"
    pages << {
        url: url,
        page_type: 'listings',
        vars: {
          category: page['vars']['category']
        }
      }
  end
end
