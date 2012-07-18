describe "after initial load", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'

  it "should render a table row for each client in the clients collection", ->
    expect($('tr.client').length).toEqual(3)

  it "should show a head icon for the head of household", ->
    expect($('tr.client:nth-child(3) > td:first-child > span').attr('class')).toEqual('head')

describe "when clients have data errors", ->
  beforeEach ->
    loadFixtures 'client_quickcheck_with_client_errors'

  it "should show exclamation icon for a client with no birthdate", ->
    expect($('tr.client:nth-child(4) > td:first-child > span:nth-child(3)').attr('class')).toEqual('errors')

  it "should show exclamation icon for a client with no race", ->
    expect($('tr.client:nth-child(3) > td:first-child > span:nth-child(3)').attr('class')).toEqual('errors')

  it "should show exclamation icon for a client with no gender", ->
    expect($('tr.client:nth-child(2) > td:first-child > span:nth-child(3)').attr('class')).toEqual('errors')

describe "Warn and waive the requirements for clients and qualification documents", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'

  it "if not current, should change the warn text to 'Unwarn'", ->
    $('.warn')[0].click()
    expect($('.warn:first').text()).toEqual("Unwarn")

  it "should increment the warning count for clients if not current", ->
    expect($($('.count')[0])).toHaveText("0")
    $('.warn')[0].click()
    expect(qualdoc.clients.models[2].get('warnings')).toEqual(1) # models are indexed in reverse order as they're rendered bottom first
    expect($($('.count')[0])).toHaveText("1")

  it "should not increment the warning count for clients if current", ->
    expect($($('.count')[2])).toHaveText("0")
    $('.warn')[2].click()
    expect(qualdoc.clients.models[0].get('warnings')).toEqual(0)
    expect($($('.count')[2])).toHaveText("0")

  it "should change the icon from error to warning for clients if not current", ->
    expect($('tr.client:nth-child(2) .status_icon').hasClass('errors')).toBeTruthy()
    $('.warn')[0].click()
    expect($('tr.client:nth-child(2) .status_icon').hasClass('errors')).toBeFalsy()
    expect($('tr.client:nth-child(2) .status_icon').hasClass('warn_icon')).toBeTruthy()

  it "should increment the warning count for household qualification documents if not current", ->
    expect($($('.count')[3])).toHaveText("0")
    $('.warn')[3].click()
    expect(qualdoc.household_docs.models[2].get('warnings')).toEqual(1)
    expect($($('.count')[3])).toHaveText("1")

  it "should change the icon from error to warning for household qualification documents if not current", ->
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('errors')).toBeTruthy()
    $('.warn')[3].click()
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('errors')).toBeFalsy()
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('warn_icon')).toBeTruthy()

describe "Complete the quickcheck process", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'
    $('.warn')[0].click()
    $('.warn')[1].click()
    $('.warn')[2].click()
    $('.warn')[3].click()
    $('.warn')[4].click()
    $('.warn')[5].click()

  it "all clients and qualdocs should either be warned, confirmed, or have status= current", ->

  it "should show the quickcheck completed button", ->
    debugger

describe "Reversible warning", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'
    $('.warn')[0].click()

  it "if not current, should change the warn text to 'Unwarn' and back to 'Warn'", ->
    expect($('.warn:first').text()).toEqual("Unwarn")
    $('.warn')[0].click()
    expect($('.warn:first').text()).toEqual("Warn")

  it "if not current, should increment the warnings count and then decrement it again", ->
    expect(qualdoc.clients.models[2].get('warnings')).toEqual(1)
    $('.warn')[0].click()
    expect(qualdoc.clients.models[2].get('warnings')).toEqual(0)


describe "confirm hard copy document for each client and each household doc", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'
    dd = new Date()
    @date_string = [dd.getFullYear(),dd.getMonth(),dd.getDate()].join('-')

  it "should set the confirm attribute to true for clients", ->
    $('.confirm')[0].click()
    expect(qualdoc.clients.models[2].get('confirm')).toBeTruthy()

  it "should set the confirm attribute to true for household qualification documents", ->
    $('.confirm')[3].click()
    expect(qualdoc.household_docs.models[2].get('confirm')).toBeTruthy()

  it "should set the date to today's date for clients", ->
    $('.confirm')[0].click()
    expect(qualdoc.clients.models[2].get('date')).toEqual(@date_string)
    expect($('tr.client:nth-child(2) .date').text()).toEqual(@date_string)

  it "should set the date to today's date for household qualification documents", ->
    $('.confirm')[3].click()
    expect(qualdoc.household_docs.models[2].get('confirm')).toBeTruthy()
    expect(qualdoc.household_docs.models[2].get('date')).toEqual(@date_string)

  it "should remove the error flag for client", ->
    expect($('tr.client:nth-child(2) .status_icon').hasClass('errors')).toBeTruthy()
    $('.confirm')[0].click()
    expect($('tr.client:nth-child(2) .status_icon').hasClass('errors')).toBeFalsy()

  it "should remove the warning flag for client", ->
    $('.warn')[0].click()
    $('.confirm')[0].click()
    expect($('tr.client:nth-child(2) .status_icon').hasClass('warn_icon')).toBeFalsy()

  it "should remove the error flag for household qualification document", ->
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('errors')).toBeTruthy()
    $('.confirm')[3].click()
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('errors')).toBeFalsy()

  it "should remove the warning flag for household qualification document", ->
    $('.warn')[3].click()
    $('.confirm')[3].click()
    expect($('tr.household_doc:nth-child(6) .status_icon').hasClass('warn_icon')).toBeFalsy()

  it "should set the status to current for clients", ->
    $('.confirm')[0].click()
    expect($('tr.client:nth-child(2) .status').text()).toEqual("current")

  it "should set the status to current for household qualification documents", ->
    $('.confirm')[3].click()
    expect($('tr.household_doc:nth-child(6) .status').text()).toEqual("current")

describe "Upload document for the first client", ->
  beforeEach ->
    loadFixtures 'client_quickcheck'

  xit "should make the upload form visible when 'upload...' is clicked", ->
    $('#upload').click()
    expect($('#upload_form')).toBeVisible()
