describe "root URL" do
  it "has a level one heading with the text 'Currency pairs'", points: 1 do
    visit "/"

    expect(page).to have_tag("h1", text: /Currency\s+pairs/i)
  end
end

describe "root URL" do
  it "lists each of the Currency Symbols from the API", points: 2 do
    visit "/"
    expect(page).to have_content("EUR")
    expect(page).to have_content("USD")
    expect(page).to have_content("JPY")
    expect(page).to have_content("BGN")
    expect(page).to have_content("CZK")
    expect(page).to have_content("DKK")
    expect(page).to_not have_content("GBP"),
      "Expected not to find the symbol 'GBP', hardcoded into the HTML but found it anyway."
  end
end

describe "root URL" do
  it "has a link to '/X', where 'X' is a currency symbol, for each currency symbol", points: 1 do
    visit "/"

    expect(page).to have_tag("a", :with => { :href => "/EUR" })
    expect(page).to have_tag("a", :with => { :href => "/USD" })
    expect(page).to have_tag("a", :with => { :href => "/JPY" })
    expect(page).to have_tag("a", :with => { :href => "/BGN" })
    expect(page).to have_tag("a", :with => { :href => "/CZK" })
    expect(page).to have_tag("a", :with => { :href => "/DKK" })
  end
end

describe "/[CURRENCY SYMBOL]" do
  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL]'", points: 1 do
    visit "/EUR"

    expect(page).to have_tag("h1", text: /Convert\s+EUR/i)
  end
end

describe "/[CURRENCY SYMBOL]" do
  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL]'", points: 1 do
    visit "/USD"

    expect(page).to have_tag("h1", text: /Convert\s+USD/i)

    visit "/JPY"

    expect(page).to have_tag("h1", text: /Convert\s+JPY/i)
  end
end

describe "/[CURRENCY SYMBOL]" do
  it "has a link with the text 'back' to root URL", points: 1 do
    visit "/CZK"

    expect(page).to have_tag("a", :with => { :href => "/" }, :text => /back/i),
      "Expected to find <a> tag with the text 'back' and an href='/', but did not find one."
  end
end

describe "/[CURRENCY SYMBOL]" do
  it "has a link with the text, 'Convert 1 X to Y...', to '/X/Y', for each currency symbol", points: 1 do
    visit "/CZK"

    expect(page).to have_tag("a", :with => { :href => "/CZK/EUR" }, :text => /Convert\s+1\s+CZK\s+to\s+EUR/i),
      "Expected page to have a link with the text, 'Convert 1 CZK to EUR...', with an href='/CZK/EUR', but did not find one."

    expect(page).to have_tag("a", :with => { :href => "/CZK/BGN" }, :text => /Convert\s+1\s+CZK\s+to\s+BGN/i),
      "Expected page to have a link with the text, 'Convert 1 CZK to BGN...', with an href='/CZK/BGN', but did not find one."
  end
end

describe "/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL] to [CURRENCY SYMBOL]'", points: 1 do
    visit "/USD/EUR"

    expect(page).to have_tag("h1", text: /Convert\s+USD\s+to\s+EUR/i)
  end
end

describe "/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has the text '1 [CURRENCY SYMBOL] equals [CURRENCY SYMBOL]'", points: 1 do
    visit "/USD/EUR"
    p page.text
    expect(page).to have_text(/1\s+USD\s+equals\s+0.9247900944\s+EUR/i),
      "Expected page to have text that follows the pattern, '1 USD equals 0.9247900944 EUR', but it didn't."
  end
end

describe "/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a link with the text 'back' to '/[CURRENCY SYMBOL]'", points: 1 do
    visit "/USD/EUR"

    expect(page).to have_tag("a", :with => { :href => "/USD" }, :text => /back/i)
  end
end

describe "/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a link with the text 'back' to '/[CURRENCY SYMBOL]'", points: 1 do
    visit "/USD/EUR"

    expect(page).to have_tag("a", :with => { :href => "/USD" }, :text => /back/i)
  end
end
