# global jQuery */
# !	
# Bootstrap Progressbar Labels v1.0
# Copyright 2013, Josh McArthur, joshmcarthur.com
# Released under the MIT license 
# 


$ = jQuery

$.fn.progressBarLabels = ->
	@each ->
		progress = $(this)
		maximum = progress.data('label-max')
		step    = progress.data('label-step')
		minimum = progress.data('label-min') || 0
		label_append = progress.data('label-append') || ""

		return unless maximum and step
		return unless progress.hasClass('progress')

		container = $('<div></div>')
		container.addClass('label-group')
		container.width("100%")

		for index in [0..((maximum - minimum) / step)]
			multiplier = container.width() / (maximum - minimum)
			label = $("<label></label>")

			# Position labels beside one another
			label.css(
				"left": "#{index * (step * multiplier)}%",
				"width": "#{step * multiplier}%",
				"display": "block",
				"text-align": "center",
				"position": "absolute",
				"margin-left": "-#{(step * multiplier) / 2}%"
			)
			label.html(((index * step) + minimum) + label_append)

			# Add line through progress bar
			vertical_rule = $('<div></div>')
			vertical_rule.css(
				"position": "absolute",
				"left": "50%",
				"top": "-#{progress.height()/4}px",
				"height": "#{progress.height()/2}",
				"border-left": "solid 2px #666666"
			)

			# Exceptions - first or last element
			if index == 0
				vertical_rule.css("border-left": "none")

			if index == ((maximum - minimum) / step)
				vertical_rule.css("border-left": "none")

			label.prepend(vertical_rule)

			container.append(label)

		progress.append(container)
		progress.css("position": "relative", "overflow": "visible")
		container.css("top": progress.height(), "position": "absolute")


$ ->
	$('.progress-labelled').progressBarLabels()
