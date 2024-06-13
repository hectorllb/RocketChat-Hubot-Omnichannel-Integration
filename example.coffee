module.exports = (robot) ->
  conversations = {}

  activators = [
    "hello", "hi", "help", "support", "I need help", "inquiry",
    "question", "talk to support", "customer service", "client service",
    "contact", "start conversation", "talk to someone", "I have a question",
    "problem", "doubt", "assistance", "technical support", "chat with support"
  ]

  robot.hear new RegExp(activators.join('|'), 'i'), (res) ->
    userId = res.message.user.id
    unless conversations[userId]
      conversations[userId] = step: 0
      res.send '''
      Hello, I am name_bot, the customer service robot! Welcome to the support of mycompany Who would you like to talk to?
      1. Inquire about our products
      2. Request shipping information
      3. Report an issue with an order
      4. Talk to a sales representative
      5. Inquiry/Issue with an invoice
      6. Another inquiry
      '''

  robot.hear /1|2|3|4|5|6/i, (res) ->
    userId = res.message.user.id
    unless conversations[userId]
      return res.send 'Please start the conversation with "name_bot".'

    step = conversations[userId].step

    switch step
      when 0 then handleFirstStep res, conversations[userId]
      else
        res.send 'Thank you for using our customer service. Can I help you with anything else?'
        delete conversations[userId]

  handleFirstStep = (res, convo) ->
    choice = res.match[0]
    departmentId = null
    switch choice
      when '1'
        departmentId = 'id_department_for_transfer' # ID of the products inquiry department
        res.send 'You have selected to inquire about our products. A representative will contact you soon.'
      when '2'
        departmentId = 'id_department_for_transfer' # ID of the shipping information department
        res.send 'You have selected to request shipping information. A representative will contact you soon.'
      when '3'
        departmentId = 'id_department_for_transfer' # ID of the order issue department
        res.send 'You have selected to report an issue with an order. A representative will contact you soon.'
      when '4'
        departmentId = 'id_department_for_transfer' # ID of the sales department
        res.send 'You have selected to talk to a sales representative. A representative will contact you soon.'
      when '5'
        departmentId = 'id_department_for_transfer' # ID of the invoice inquiry department
        res.send 'You have selected inquiry/issue with an invoice. A representative will contact you soon.'
      when '6'
        departmentId = 'id_department_for_transfer' # ID of the support department
        res.send 'You have selected another inquiry. A representative will contact you soon.'
      else
        res.send 'Invalid option. Please select 1, 2, 3, 4, 5, or 6.'
        return

    convo.step = 1
    transferToDepartment res, departmentId

  transferToDepartment = (res, departmentId) ->
    params =
      roomId: res.envelope.room
      departmentId: departmentId

    robot.adapter.callMethod('livechat:transfer', params).then (result) ->
      if result.success
        res.send "Transfer successful. A representative will contact you as soon as possible."
      else
        res.send "Transfer failed. Please try again later."
      console.log result
