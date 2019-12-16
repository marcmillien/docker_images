require 'docker-api'
require 'serverspec'

image = ENV['IMAGE']
repository = ENV['REPOSITORY']

describe 'Dockerfile' do
  before(:all) do
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, "#{repository}/#{image}"
    set :docker_url, 'unix:///var/run/docker.sock'
    set :docker_container_create_options, {
      'Entrypoint' => [ '/bin/sh' ]
    }
  end

  describe command('echo "ok"') do
    its(:exit_status) { should eq 0 }
  end
end
