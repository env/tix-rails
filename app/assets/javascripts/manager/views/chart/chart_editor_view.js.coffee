class TixMgr.Views.ChartEditorView extends Backbone.View
  
  events:
    'blur #chart_properties input[data-type="field"]': 'save'
  
  
  initialize: (data)->
    # console.log 'TixMgr.Views.ChartEditorView initialized'
    chart = data.chart
    @model = new TixMgr.Models.Chart(chart)
    
    # BEFORE rendering
    @respondToAreaClicks()
    @setupChartPropertiesView()
    chart = @associateAreaPricesWithSectionPrices(chart) 
    
    # RENDER Raphael Chart
    new TixLib.Views.ChartRenderView({el: $( '#chart_container'), chart: chart, mode: 'mgr'})    

    # After rendering
    @fireChartColorChange()
        
    # _.bindAll this, 
    
  
  associateAreaPricesWithSectionPrices: (chart)->
    
    _.each chart.sections, (section)->
      _.each section.areas, (area)->
        area.prices = section.prices
        
    return chart
        
        
  setupChartPropertiesView: ->
    chart_properties_template = JST['manager/templates/chart_edit']
    $('#chart_properties').html( chart_properties_template( { section: chart.sections, area: chart.areas, chart: chart} ) )
    
  fireChartColorChange: ->
    self = this
    $('.chart-colorpicker input').miniColors
      change: (hex, rgb)->
        TixLib.Dispatcher.trigger('chartColorChange', {color: hex })
        self.model.set('background_color', hex)
      close: ->
        self.model.save {},
          success: ->
            console.log 'success'
            $('.chart-colorpicker input').parent().effect('highlight')
        
        
    
  save: ->
    console.log 'Save Called'
    self = this
    
    self.$el.find('[data-type="field"]').each (idx, field_el)->
      field_name = $(field_el).data('fieldname')
      field_val = $(field_el).val()
      self.model.set(field_name, field_val)
      console.log '[SR] Saving model chart with field val'
      console.log [field_name, field_val]
    
    self.model.save()
  
  respondToAreaClicks: ->
    self = this
    TixLib.Dispatcher.on 'areaClick', (data)->
      area = data.area
      section = data.section
      
      console.log ['area + section', area, section]
      
      # Seat Edit (only if area is seatable )
      # Garbage Collection
      self.seat_view.leave() unless self.seat_view == undefined
      
      if section.seatable
        self.seat_view = new TixMgr.Views.ChartEditSeatView
          section: section
          area: area
      
        $('#col2').html(self.seat_view.render().$el)
        
      # Section Edit
      self.section_view.leave() unless self.section_view == undefined
      self.section_view = new TixMgr.Views.ChartEditSectionView
        section: section
        area: area
      $('#col3').html(self.section_view.render().$el)
      
      # Price Edit
      
     
      console.log 'apending widget'
      
      self.presale_price_view.leave() unless self.presale_price_view == undefined
      self.presale_price_view = new TixMgr.Views.ChartEditPriceView
        price: section.presale_price
        label: 'Presale Price'
        
      
      self.dayof_price_view.leave() unless self.dayof_price_view == undefined
      self.dayof_price_view = new TixMgr.Views.ChartEditPriceView
        price: section.dayof_price
        label: 'Day of Price'
        
        
      
      widget = new TixMgr.Views.WidgetView
        title: 'Prices'
        content: [
          self.presale_price_view.render().$el
          self.dayof_price_view.render().$el
        ]
      $('#col3').append( widget.render().$el )
  
        
        

      
    