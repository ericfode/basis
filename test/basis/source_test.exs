defmodule Basis.SourceTest do
  use ExUnit.Case, async: true

  test "splits markdown into source-topology sections without semantic labels" do
    source = Basis.Source.read!("components/spec-basis-reducer/spec.md")

    assert source.hash

    assert [%{id: "section-001", title: "Spec Basis Reducer Component Specification"} | _] =
             source.sections
  end
end
