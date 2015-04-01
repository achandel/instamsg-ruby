module Instamsg
  class Resource
    def initialize(client, path)
      @client = client
      @path = path
    end

    def get(params)
      create_request(:get, params).send_sync
    end

    def get_async(params)
      create_request(:get, params).send_async
    end

    def post(params)
      body = MultiJson.encode(params)
      create_request(:post, {}, body).send_sync
    end

    def post_async(params)
      body = MultiJson.encode(params)
      create_request(:post, {}, body).send_async
    end
    
    def put(params)
      body = MultiJson.encode(params)
      create_request(:put, {}, body).send_sync
    end
    
    def put_async(params)
      body = MultiJson.encode(params)
      create_request(:put, {}, body).send_async
    end
    
    def delete(params)
      create_request(:delete, params).send_sync
    end
    
    def delete_async(params)
      create_request(:delete, params).send_async
    end
    
    def download(params)
      create_request(:post, params).send_sync
    end
    
    def upload(params)
      create_request(:post, params).upload_sync
    end
    
    def authenticate(params)
      authenticate_request(:post, params).send_sync
    end

    private

    def create_request(verb, params, body = nil)
      Request.new(@client, verb, url, token, params, body)
    end
    
    def authenticate_request(verb, params, body = nil)
      Request.new(@client, verb, url, @client.access_token, params, body)
    end

    def url
      @_url ||= @client.url(@path)
    end
    
    def token
      @token ||= @client.bearer_token
    end
  end
end
