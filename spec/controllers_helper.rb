class Exposed
  attr_accessor :object, :serializer, :collection
end

class NilAbility
  def can?( _, _ )
    false
  end
end

class FakeAbility
  def initialize( permission, resource )
    @abilities = []
    @abilities << [ permission, resource ]
  end

  def can?( permission, resource )
    @abilities.any? { |a| a[0] == permission && a[1] == resource }
  end

  def add_ability( permission, resource )
    @abilities << [ permission, resource ]
  end
end
