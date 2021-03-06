'use strict'

class Sprangular.Address
  Validity.define @,
    firstname: 'required'
    lastname: 'required'
    address1: 'required'
    city: 'required'
    state: ['_validateState']
    country: 'required'
    zipcode: 'required'
    phone: 'required'

  init: ->
    @stateId = @state_id
    @countryId = @country_id

  fullName: ->
    "#{@firstname} #{@lastname}"

  shortAddress: ->
    "#{@fullName()}, #{@addressLine()}"

  actualStateName: ->
    @state?.abbr || @state_name

  addressLine: ->
    if @address2
      @address1 + " " + @address2
    else
      @address1

  serialize: ->
    firstname: @firstname
    lastname: @lastname
    address1: @address1
    address2: @address2
    city: @city
    phone: @phone
    zipcode: @zipcode
    state_id: @stateId
    state_name: @state_name
    country_id: @countryId

  isEmpty: ->
    !@firstname &&
    !@lastname &&
    !@address1 &&
    !@address2 &&
    !@city &&
    !@phone &&
    !@zipcode &&
    !@countryId &&
    !@stateId

  same: (other) ->
    return unless other
    @firstname == other.firstname &&
      @lastname == other.lastname &&
      @address1 == other.address1 &&
      @address2 == other.address2 &&
      @city == other.city &&
      @phone == other.phone &&
      @zipcode == other.zipcode &&
      @countryId == other.countryId &&
      @stateId == other.stateId

  key: ->
    [@firstname,
     @lastname,
     @address1,
     @address2,
     @city,
     @phone,
     @zipcode,
     @countryId,
     @stateId].join('')

  _validateState: ->
    "can't be blank" if (@country && @country.states_required) && !@actualStateName()
