import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ListComingSoonEpisodesComponent } from './list-coming-soon-episodes.component';

describe('ListComingSoonEpisodesComponent', () => {
  let component: ListComingSoonEpisodesComponent;
  let fixture: ComponentFixture<ListComingSoonEpisodesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ListComingSoonEpisodesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListComingSoonEpisodesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
