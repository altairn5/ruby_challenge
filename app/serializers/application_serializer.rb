class ApplicationSerializer
  attr_reader :collection, :entity

  def initialize( options = {} )
    options.to_options!
    @entity = options.fetch(:entity, 'data')
  end

  def as_json(&block)
    data_wrapper( data ).tap do |json|
      yield( json ) if block_given?
    end
  end

  def to_json(*args, &block)
    JSON.dump( root_wrapper( as_json ) ).tap do |json|
      yield( json ) if block_given?
    end
  end

  private

  def data_wrapper( data )
      data.deep_stringify_keys
  end

  def root_wrapper( data )
    Hash(entity => data)
  end
end
