# frozen_string_literal: true

module Latte
  #
  module Multiple
    extend ActiveSupport::Concern

    included do
      respond_to :json

      before_action :ngtable_to_rails_filter_param, only: [:index]
      before_action :ngtable_to_rails_sort_param,   only: [:index]
    end

    def update
      respond_to do |format|
        format.html { super }
        format.json do
          sleep 0.5

          return render json: { success: true } if
            @item.update_attributes(item_params)

          render json: { success: false }
        end
      end
    end

    def updates
      model.where(id: params[:ids]).each do |item|
        item.assign_attributes(item_params.to_hash)
        item.save(validate: false)
      end
    end

    def destroys
      model.where(id: params[:ids]).each(&:destroy)
    end

    def index
      respond_to do |format|
        format.html { super }
        format.csv  { super }
        format.json { respond_to_json }
      end
    end

    def collection_with_translations
      collection = if model.respond_to?(:with_translations)
                     policy_scope(model).with_translations(I18n.locale)
                   else
                     policy_scope(model)
                   end
      collection.ransack(params[:filter])
    end

    def respond_to_json
      @c = collection_with_translations
           .result
           .paginate(page: params[:page], per_page: params[:count])

      render json: json_result(@c)
    end

    def json_result(collection)
      {
        result:        json_parsed(collection),
        total_entries: collection.total_entries,
        admin_setting: current_admin.admin_setting
      }
    end

    def json_parsed(collection)
      collection = collection.decorate
      attach_permissions(collection)

      collection.as_json(
        include: json_includes,
        methods: json_methods
      )
    end

    def attach_permissions(collection)
      %i[destroy update].each do |x|
        collection.each do |o|
          if policy(o).send("#{x}?")
            it_can(o, x)
          else
            it_cant(o, x)
          end
        end
      end
    end

    def it_can(o, action)
      o.define_singleton_method "can_#{action}" do
        true
      end
    end

    def it_cant(o, action)
      o.define_singleton_method "can_#{action}" do
        false
      end
    end

    def json_includes
      nil
    end

    def json_methods
      %i[can_destroy can_update]
    end

    def list
      render json: policy_scope(model)
        .select(:id, model.acts_as_label)
        .order(model.acts_as_label)
        .to_json
    end

    private

    def ngtable_to_rails_filter_param
      return unless params.key?(:filter)
      params[:filter]
        .update(params[:filter]) { |_k, v| URI.decode_www_form_component(v) }
        .delete_if { |_k, v| v == 'null' }
    end

    def ngtable_to_rails_sort_param
      return unless params.key?(:sorting)

      params[:filter] ||= {}
      params[:filter][:s] = params[:sorting].flatten.join(' ')
    end
  end
end
