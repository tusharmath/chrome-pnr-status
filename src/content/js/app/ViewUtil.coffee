define ['komapping','knockout'], (komapping, ko) ->
	class ViewUtil
		bindView: (data, id) ->
			viewModel = komapping.fromJS(data)
			ko.applyBindings viewModel, document.getElementById id
			viewModel

		updateView: (data, viewModel) ->
			komapping.fromJS data, viewModel
			viewModel