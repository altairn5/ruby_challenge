class ApplicationSerializer
  attr_reader :collection

  def initialize( options = {} )
    options.to_options!
    @collection ||= options.fetch(:collection, false)
  end

  def data
    raise NotImplementedError
  end

  def errors
    raise NotImplementedError
  end

  def errors?
    false
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
    # (errors? ? errors : data).deep_stringify_keys
    data.deep_stringify_keys
  end

  def root_wrapper( data )
    Hash('data' => data )
  end
end