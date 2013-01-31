describe "Bootstrap Labelled Progressbars", ->
	beforeEach ->
		$('<div class="progress" data-label-max="100" data-label-step="10"><div class="bar" style="width:60%"></div></div>').appendTo('body')

	afterEach ->
		$('.progress').remove()

	it 'should be defined on the jQuery object', ->
		expect($(document.body).progressBarLabels).toBeTruthy()

	it 'should be chainable', ->
		progress = $('.progress')
		progress.progressBarLabels().addClass('progress-labelled')
		expect(progress.hasClass('progress-labelled')).toBeTruthy()

	it 'should automatically add labels if progress bar has correct class', ->
		$('.progress').addClass('progress-labelled')
		$('.progress-labelled').progressBarLabels()
		expect($('.label-group', '.progress').length).toBe(1)

	it 'should not do anything if the element is not a progress bar', ->
		$(document.body).progressBarLabels()
		expect($('.label-group').length).toBe(0)

	it 'should not do anything if there is no maximum or step set on the element', ->
		$('.progress').removeAttr('data-label-max').removeAttr('data-label-step')
		$('.progress').progressBarLabels()
		expect($('.label-group').length).toBe(0)

	it 'should add a label container to a correctly configured element', ->
		$('.progress').progressBarLabels()
		expect($('.label-group', '.progress').length).toBe(1)

	it 'should add the correct number of step labels', ->
		$('.progress').progressBarLabels()

		# There are 11 steps including zero
		expect($('label', '.progress .label-group').length).toBe(11)

	it 'should draw bars on the progress bar', ->
		$('.progress').progressBarLabels()
		expect($('div', '.progress .label-group label').length).toBe(11)
