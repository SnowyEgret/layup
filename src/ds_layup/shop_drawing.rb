module DS
module LayUp
  class ShopDrawing
    def self.test
      path = File.join(__dir__, '../../test/test.layout')
      # doc = Layout::Document.new(path)
      doc = Layout::Document.new
      # test_table(doc)
      # test_model(doc)
      test_dimension(doc)
      doc.grid.show = true
      doc.save(path)

      # entities = doc.shared_entities
      # p entities.length
      # entities.each do |ent|
      #   p ent
      # end
    end

    def self.test_table(doc)
      bounds = Geom::Bounds2d.new(1, 1, 4, 4)
      rows = 16
      columns = 4
      table = Layout::Table.new(bounds, rows, columns)
      layer = doc.layers.first
      doc.add_entity(table, layer, doc.pages.first)

      anchor_type = Layout::FormattedText::ANCHOR_TYPE_TOP_LEFT
      start_point = Geom::Point2d.new(1, 1)
      text = Layout::FormattedText.new("Hello LayOut", start_point, anchor_type)
      table[1, 1].data = text
    end

    def self.test_dimension(doc)
      start_point = Geom::Point2d.new(1, 1)
      end_point = Geom::Point2d.new(5, 5)
      height = 1.0
      dim = Layout::LinearDimension.new(start_point, end_point, height)
      layer = doc.layers.first
      page = doc.pages.first
      doc.add_entity(dim, layer, page)
    end

    def self.test_model(doc)
      # info = doc.page_info
      # p info.width
      # p info.height
      bounds = Geom::Bounds2d.new(1, 1, 6, 6)
      # path = File.join(__dir__, '../../test/LayUp test.skp/')
      path = 'C:/Users/Duncan/SketchUp Extensions/LayUp/test/LayUp test.skp'
      model = Layout::SketchUpModel.new(path, bounds)
      model.perspective = false
      model.view = Layout::SketchUpModel::TOP_VIEW
      layer = doc.layers.first
      page = doc.pages.first
      doc.add_entity(model, layer, page)
      # page.entities.each do |ent|
      #   p ent
      # end
    end
  end
end
end
