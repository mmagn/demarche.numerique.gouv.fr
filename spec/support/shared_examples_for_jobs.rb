# frozen_string_literal: true

RSpec.shared_examples 'a job retrying standard errors' do |job_class = described_class|
  StandardErrorJob = Class.new(job_class) do
    def perform
      raise StandardError
    end
  end if !defined?(StandardErrorJob)

  context 'when another type of error is raised' do
    it 'makes 25 attempts before discarding the job (default strategy)' do
      assert_performed_jobs 25 do
        StandardErrorJob.perform_later rescue StandardError
      end
    end
  end
end
