require "rich/engine"

module Rich
  autoload :ViewHelper, 'rich/view_helper'
  autoload :FormBuilder, 'rich/form_builder'
  autoload :CustomFormBuilder, 'rich/formtastic'
    
  # Configuration defaults (these map directly to ckeditor settings)
  mattr_accessor :editor
  @@editor = {
    :stylesSet  =>  [],
    :extraPlugins => 'stylesheetparser',
    :contentsCss => '/assets/rich/editor.css', # TODO: make this map to the engine mount point
    :removeDialogTabs => 'link:advanced;link:target;image:Link;image:advanced',
    :startupOutlineBlocks => true,
    :format_tags => 'h3;p;pre',
    :toolbar => [['Format','Styles'],['Bold', 'Italic', '-','NumberedList', 'BulletedList', 'Blockquote', '-', 'Image', '-', 'Link', 'Unlink'],['PasteFromWord'],['Source', 'ShowBlocks']],
    
    :uiColor => '#f4f4f4', # similar to Active Admin
  }
  # End configuration defaults
  
  def self.setup
    yield self
  end
  
  def self.insert
    # TODO: link asset to user definable entity <%= form.cktext_area :content, :swf_params=>{:assetable_type=>'User', :assetable_id=>current_user.id} %>
    ActionView::Base.send(:include, Rich::ViewHelper)
    ActionView::Helpers::FormBuilder.send(:include, Rich::FormBuilder)
    
    if Object.const_defined?("Formtastic")
      Formtastic::SemanticFormHelper.builder = Rich::CustomFormBuilder
    end
  end
  
end