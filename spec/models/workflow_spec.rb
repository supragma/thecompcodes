require 'rails_helper'

describe Workflow, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:request) }
end
