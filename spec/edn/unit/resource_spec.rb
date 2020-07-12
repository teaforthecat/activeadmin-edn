require 'spec_helper'
include ActiveAdmin

module ActiveAdmin
  module Edn
    describe Resource do
      let(:resource) { ActiveAdmin.register(Post) }

      let(:custom_builder) do
        Builder.new(Post) do
          column(:fake) { :fake }
        end
      end

      context 'when registered' do
        it 'each resource has an edn_builder' do
          expect(resource.edn_builder).to be_a(Builder)
        end

        it 'We can specify our own configured builder' do
          expect { resource.edn_builder = custom_builder }.not_to raise_error
        end
      end
    end
  end
end
